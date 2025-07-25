package identity

// ID represents a node identity.
type ID string

// New creates a new identity from a name.
func New(name string) ID {
	return ID(name)
}

func (id ID) String() string {
	return string(id)
}
