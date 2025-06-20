package com.identity.platform.identity.context.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class IdentitycontextserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(IdentitycontextserviceApplication.class, args);
    }
}
