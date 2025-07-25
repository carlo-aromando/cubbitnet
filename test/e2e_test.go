package test

import (
	"testing"

	"cubbit.eu/cubbitnet/pkg/message"
	"cubbit.eu/cubbitnet/pkg/node"
)

func TestE2E(t *testing.T) {
	expectFrom := "from"
	expectTo := "to"
	expectContent := "hello e2e"
	identity := "test-node"
	node := node.NewNode(identity)

	addr := "remote-address"
	msg := message.BuildMessage(expectFrom, expectTo, "hello e2e")

	if err := node.SendTo(addr, msg); err != nil {
		t.Fatalf("SendTo failed: %v", err)
	}

	recvMsg, err := node.Receive()
	if err != nil {
		t.Fatalf("Receive failed: %v", err)
	}

	from, to, content := message.ParseMessage(recvMsg)

	if from != expectFrom {
		t.Errorf("unexpected from: got %s want %s", from, expectFrom)
	}

	if to != expectTo {
		t.Errorf("unexpected to: got %s want %s", to, expectTo)
	}

	if content != expectContent {
		t.Errorf("unexpected content: got %s want %s", content, expectContent)
	}
}
