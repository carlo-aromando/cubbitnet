package main

import (
	"fmt"
	"log"

	"github.com/linxGnu/grocksdb"
)

func main() {
	opts := grocksdb.NewDefaultOptions()
	opts.SetCreateIfMissing(true)

	db, err := grocksdb.OpenDb(opts, "./testdb")
	if err != nil {
		log.Fatalf("Errore apertura DB: %v", err)
	}
	defer db.Close()

	wo := grocksdb.NewDefaultWriteOptions()
	ro := grocksdb.NewDefaultReadOptions()
	defer wo.Destroy()
	defer ro.Destroy()

	err = db.Put(wo, []byte("ciao"), []byte("mondo"))
	if err != nil {
		log.Fatalf("Errore nella Put: %v", err)
	}

	val, err := db.Get(ro, []byte("ciao"))
	if err != nil {
		log.Fatalf("Errore nella Get: %v", err)
	}
	defer val.Free()

	fmt.Printf("Valore letto: %s\n", val.Data())
}
