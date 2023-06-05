/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   main.cpp                                           :+:    :+:            */
/*                                                     +:+                    */
/*   By: wkonings <wkonings@student.codam.nl>         +#+                     */
/*                                                   +#+                      */
/*   Created: 2023/06/05 13:45:42 by wkonings      #+#    #+#                 */
/*   Updated: 2023/06/05 19:13:45 by wkonings      ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#define PORT 8080
#define MINIHELL 1

#include <sys/socket.h> // For socket functions
#include <netinet/in.h> // For sockaddr_in
#include <cstdlib> // For exit() and EXIT_FAILURE
#include <iostream> // For cout
#include <unistd.h> // For read

int main() {
	// Create a socket (IPv4, TCP)
	int sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if (sockfd == -1) {
		std::cout << "Failed to create socket. errno: " << errno << std::endl;
		exit(EXIT_FAILURE);
	}

	// Listen to port [] on any address
	sockaddr_in sockaddr;
	sockaddr.sin_family = AF_INET;
	sockaddr.sin_addr.s_addr = INADDR_ANY;
	sockaddr.sin_port = htons(PORT); // htons is necessary to convert a number to
								   // network byte order
	if (bind(sockfd, (struct sockaddr*)&sockaddr, sizeof(sockaddr)) < 0) {
		std::cout << "Failed to bind to port. errno: " << errno << std::endl;
		exit(EXIT_FAILURE);
	}

	// Start listening. Hold at most 10 connections in the queue
	if (listen(sockfd, 10) < 0) {
		std::cout << "Failed to listen on socket. errno: " << errno << std::endl;
		exit(EXIT_FAILURE);
	}

	// Grab a connection from the queue
	int addrlen = sizeof(sockaddr);
	int connection = accept(sockfd, (struct sockaddr*)&sockaddr, (socklen_t*)&addrlen);
	if (connection < 0)
	{
		std::cout << "Failed to grab connection. errno: " << errno << std::endl;
		exit(EXIT_FAILURE);
	}

	char hello[] = "HTTP/1.1 200 OK\nContent-Type: text/plain\nContent-Length: 12\n\nHello world!";
	// Read from the connection
	while (MINIHELL)
	{
		char buffer[100] = {0};
		int bytesRead = read(connection, buffer, 100);
		buffer[bytesRead - 2] = 0; //removes endl and bonus character?
	
		std::cout << "The message was: " << buffer << std::endl;

		// Send a message to the connection
		std::string response = "Good talking to you\n";
		send(connection, response.c_str(), response.size(), 0);
	
		if (strcmp(buffer, "exit") == 0)
			break;
	}

	// Close the connections
	close(connection);
	close(sockfd);
}