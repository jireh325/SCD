package com.identity.platform.identity.registry.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class IdentityregistryserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(IdentityregistryserviceApplication.class, args);
    }
}
