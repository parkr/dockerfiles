package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"time"
)

type LogLine struct {
	Now     string
	Path    string
	Method  string
	BodyLen int
	Body    string
	Error   error `json:",omitempty"`
}

func main() {
	var listenAddr string
	flag.StringVar(&listenAddr, "listen", ":8080", "IP:PORT to listen on")
	flag.Parse()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)

		// Let's be smart and write JSON-encoded, newline-delimited log lines. Easier to machine-parse.
		bodyLen, body, err := readBody(r, 10_000)
		logLine := &LogLine{
			Now:     time.Now().Format(time.RFC3339),
			Path:    r.URL.Path,
			Method:  r.Method,
			BodyLen: bodyLen,
			Body:    body,
			Error:   err,
		}
		if logLine.Error != nil {
			log.Printf("[%s] unable to read body: %v", r.URL.Path, logLine.Error)
		}
		logOutput, err := json.Marshal(logLine)
		if err != nil {
			log.Printf("[%s] error: %v", r.URL.Path, err)
			return
		}
		fmt.Println(string(logOutput))
	})
	log.Printf("Beginning to listen on %s ...", listenAddr)
	if err := http.ListenAndServe(listenAddr, nil); err != nil {
		log.Fatalf("error serving: %v", err)
	}
}

func readBody(r *http.Request, limit int64) (int, string, error) {
	// We don't want to read the whole thing and blow up our logs; truncate to something reasonable like 5K.
	reader := io.LimitReader(r.Body, limit)
	bytes, err := io.ReadAll(reader)
	if err != nil {
		return 0, "", err
	}
	return len(bytes), string(bytes), nil
}
