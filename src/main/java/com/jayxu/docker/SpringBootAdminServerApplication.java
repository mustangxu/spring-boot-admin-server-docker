/**
 * Authored by jayxu @2021
 */
package com.jayxu.docker;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import de.codecentric.boot.admin.server.config.EnableAdminServer;

@EnableAdminServer
@SpringBootApplication
public class SpringBootAdminServerApplication {
    public static void main(String[] args) {
        try (var ctx = SpringApplication
            .run(SpringBootAdminServerApplication.class, args);) {
        }
    }
}
