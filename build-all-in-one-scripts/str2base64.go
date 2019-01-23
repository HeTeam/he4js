package main

import (
  "fmt"
  "flag"
  "os"
  "io/ioutil"
  "encoding/base64"
  "encoding/hex"
)
var (
  s string
)
func hex2base64(input string) string {
  bytes, _ := hex.DecodeString(input)
  return base64.StdEncoding.EncodeToString(bytes)
}
func str2base64(input string) string {
  return base64.StdEncoding.EncodeToString([]byte(input))
}
func main() {
  flag.StringVar(&s, "s", "", "path")
  flag.Parse();
  //fmt.Println(s)
  allString := read(s)
  //fmt.Println(allString)
  //fmt.Println(hex2base64(allString))
  fmt.Println(str2base64(allString))
}
func read(path string)string{
  fi,err := os.Open(path)
  if err != nil{panic(err)}
  defer fi.Close()
  fd,err := ioutil.ReadAll(fi)
  
  // fmt.Println(string(fd))
  return string(fd)
}
