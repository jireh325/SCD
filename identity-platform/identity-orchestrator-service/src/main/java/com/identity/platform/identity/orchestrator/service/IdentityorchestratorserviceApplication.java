package com.identity.platform.identity.orchestrator.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class IdentityorchestratorserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(IdentityorchestratorserviceApplication.class, args);
    }
}
