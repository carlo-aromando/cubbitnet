package db

import (
	"log"

	"github.com/linxGnu/grocksdb"
)

func Test() {
	opts := grocksdb.NewDefaultOptions()
	opts.SetCreateIfMissing(true)

	db, err := grocksdb.OpenDb(opts, "/tmp/testdb")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	wo := grocksdb.NewDefaultWriteOptions()
	ro := grocksdb.NewDefaultReadOptions()

	err = db.Put(wo, []byte("hello"), []byte("world"))
	if err != nil {
		log.Fatal(err)
	}

	val, err := db.Get(ro, []byte("hello"))
	if err != nil {
		log.Fatal(err)
	}

	log.Println("Value:", string(val.Data()))
	val.Free()
}
