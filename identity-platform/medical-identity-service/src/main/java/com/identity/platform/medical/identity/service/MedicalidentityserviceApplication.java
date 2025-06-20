package com.identity.platform.medical.identity.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class MedicalidentityserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(MedicalidentityserviceApplication.class, args);
    }
}
