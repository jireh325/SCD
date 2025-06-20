package com.identity.platform.family.identity.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class FamilyidentityserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(FamilyidentityserviceApplication.class, args);
    }
}
