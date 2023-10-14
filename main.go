package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.Static("/", "./www")
	//router.StaticFile("/", "./www/index.html")
	// Listen and serve on 0.0.0.0:8080
	router.Run(":8080")
}
