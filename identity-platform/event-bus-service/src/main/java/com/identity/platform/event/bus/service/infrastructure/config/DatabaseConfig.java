package com.identity.platform.event.bus.service.infrastructure.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = "com.identity.platform.event.bus.service.infrastructure.persistence")
public class DatabaseConfig {
}
