package com.identity.platform.legal.identity.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class LegalidentityserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(LegalidentityserviceApplication.class, args);
    }
}
