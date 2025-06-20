package com.identity.platform.biometric.identity.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class BiometricidentityserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(BiometricidentityserviceApplication.class, args);
    }
}
