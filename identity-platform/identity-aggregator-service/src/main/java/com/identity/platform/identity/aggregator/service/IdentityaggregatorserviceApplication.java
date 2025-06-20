package com.identity.platform.identity.aggregator.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class IdentityaggregatorserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(IdentityaggregatorserviceApplication.class, args);
    }
}
