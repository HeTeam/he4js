package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"regexp"
	"strings"
)

var (
	f         string
	s1        string
	s2        string
	s3        string
	start     string
	end       string
	newString string
)

func main() {
	flag.StringVar(&f, "f", "", "file path")
	flag.StringVar(&s1, "s1", "", "old str1")
	flag.StringVar(&s2, "s2", "", "new str2")
	flag.StringVar(&s3, "s3", "", "new str3")
	flag.StringVar(&start, "start", "", "start str")
	flag.StringVar(&end, "end", "", "end str")
	flag.Parse()

	allString := read3(f)
	oldString := s1
	re := regexp.MustCompile(oldString)
	fmt.Println("正在处理: " + s1)
	if strings.Count(s3, "") > 1 {
		newString = s3
		newString = start + newString + end
	} else {
		newString = read3(s2)
		newString = start + "\n" + newString + "\n" + end
	}

	out := re.ReplaceAllLiteral([]byte(allString), []byte(newString))
	//fmt.Println(out)
	ioutil.WriteFile(f, []byte(out), 0755)
}
func read3(path string) string {
	fi, err := os.Open(path)
	if err != nil {
		panic(err)
	}
	defer fi.Close()
	fd, err := ioutil.ReadAll(fi)
	return string(fd)
}
