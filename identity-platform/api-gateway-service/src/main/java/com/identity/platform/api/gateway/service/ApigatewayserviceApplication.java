package com.identity.platform.api.gateway.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class ApigatewayserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(ApigatewayserviceApplication.class, args);
    }
}
