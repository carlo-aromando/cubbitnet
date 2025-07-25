package main

import (
	"fmt"

	"cubbit.eu/cubbitnet/pkg/message"
	"cubbit.eu/cubbitnet/pkg/node"
	"cubbit.eu/cubbitnet/pkg/transport"
)

func main() {
	backend := transport.NewBackend()
	node := node.NewNode("alice", node.WithBackend(backend))

	msg := message.BuildMessage("alice", "bob", "hello from alice")

	if err := node.SendTo("bob", msg); err != nil {
		panic(err)
	}

	received, err := node.Receive()
	if err != nil {
		panic(err)
	}

	from, to, content := message.ParseMessage(received)
	fmt.Printf("Parsed message:\n- From: %s\n- To: %s\n- Content: %s\n", from, to, content)
}
