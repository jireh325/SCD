package com.identity.platform.professional.identity.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class ProfessionalidentityserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(ProfessionalidentityserviceApplication.class, args);
    }
}
