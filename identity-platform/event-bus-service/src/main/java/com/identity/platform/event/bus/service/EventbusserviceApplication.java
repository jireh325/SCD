package com.identity.platform.event.bus.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class EventbusserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(EventbusserviceApplication.class, args);
    }
}
