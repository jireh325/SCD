package com.identity.platform.financial.identity.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class FinancialidentityserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(FinancialidentityserviceApplication.class, args);
    }
}
