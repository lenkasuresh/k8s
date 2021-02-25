package main

import (
    "fmt"
    "log"
    "net/http"
)

func homePage(w http.ResponseWriter, r *http.Request){

     if r.Method == http.MethodGet {
         fmt.Fprintf(w, "This is a GET method!")
    } else if r.Method == http.MethodPost {
         fmt.Fprintf(w, "This is a POST method!")
    } else {
         fmt.Fprintf(w, "This is a " + r.Method + " request")
    }
}

func handleRequests() {
    http.HandleFunc("/", homePage)
    log.Fatal(http.ListenAndServe(":80", nil))
}

func main() {
    handleRequests()
}
