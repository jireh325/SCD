package com.identity.platform.monitoring.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class MonitoringserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(MonitoringserviceApplication.class, args);
    }
}
