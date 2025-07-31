package message

import (
	"fmt"
	"regexp"

	"github.com/carlo-aromando/cubbitnet/internal/codec"
)

// Message represents a generic message.
type Message struct {
	Payload []byte
}

// BuildMessage formats a simple text message into a binary format.
func BuildMessage(from, to, content string) *Message {
	raw := fmt.Sprintf("[%s→%s] %s", from, to, content)
	return &Message{Payload: codec.Encode(raw)}
}

// ParseMessage parses a message into components (naive parser).
func ParseMessage(msg *Message) (from, to, content string) {
	raw := codec.Decode(msg.Payload)
	re := regexp.MustCompile(`\[(.+)→(.+)] (.+)`)
	matches := re.FindStringSubmatch(raw)
	if matches == nil {
		return "", "", raw
	}
	return matches[1], matches[2], matches[3]
}
