package codec

// Encode encodes a string message into bytes.
func Encode(msg string) []byte {
	return []byte(msg)
}

// Decode decodes bytes into a string message.
func Decode(data []byte) string {
	return string(data)
}
