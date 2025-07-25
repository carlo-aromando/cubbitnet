package node

import (
	"fmt"
	"os"

	"github.com/rs/zerolog"

	"cubbit.eu/cubbitnet/internal/identity"
	"cubbit.eu/cubbitnet/internal/utils"
	"cubbit.eu/cubbitnet/pkg/message"
	"cubbit.eu/cubbitnet/pkg/transport"
)

// Node represents a message-capable peer.
type Node struct {
	ID      identity.ID
	backend transport.Backend
	logger  zerolog.Logger
}

// Option configures a Node during construction.
type Option func(*Node)

// WithBackend overrides the default transport backend.
func WithBackend(b transport.Backend) Option {
	return func(n *Node) {
		n.backend = b
	}
}

// NewNode creates a new Node with a given identity and options.
func NewNode(name string, opts ...Option) *Node {
	id := identity.New(name)

	node := &Node{
		ID:      id,
		backend: transport.NewBackend(),
		logger:  zerolog.New(os.Stderr).With().Str("node", id.String()).Logger(),
	}

	for _, opt := range opts {
		opt(node)
	}

	return node
}

// SendTo sends a message to a given address.
func (n *Node) SendTo(to string, msg *message.Message) error {
	if !utils.IsValidAddress(to) {
		return fmt.Errorf("invalid address: %s", to)
	}
	n.logger.Info().Str("to", to).Msg("sending message")
	return n.backend.Send(to, msg)
}

// Receive receives the next available message.
func (n *Node) Receive() (*message.Message, error) {
	msg, err := n.backend.Receive()
	if err != nil {
		return nil, err
	}
	n.logger.Info().Msg("received message")
	return msg, nil
}
