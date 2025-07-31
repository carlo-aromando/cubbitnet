package transport

import (
	"errors"
	"sync"

	"github.com/carlo-aromando/cubbitnet/pkg/message"
)

// Backend defines transport methods.
type Backend interface {
	Send(addr string, msg *message.Message) error
	Receive() (*message.Message, error)
}

// NewBackend creates a default Backend.
func NewBackend() Backend {
	return &dummyBackend{
		queue: make([]*message.Message, 0),
	}
}

// dummyBackend is a simple in-memory transport.
type dummyBackend struct {
	mu    sync.Mutex
	queue []*message.Message
}

func (d *dummyBackend) Send(addr string, msg *message.Message) error {
	d.mu.Lock()
	defer d.mu.Unlock()
	d.queue = append(d.queue, msg)
	return nil
}

func (d *dummyBackend) Receive() (*message.Message, error) {
	d.mu.Lock()
	defer d.mu.Unlock()
	if len(d.queue) == 0 {
		return nil, errors.New("no messages")
	}
	msg := d.queue[0]
	d.queue = d.queue[1:]
	return msg, nil
}
