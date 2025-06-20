package com.identity.platform.config.service.infrastructure.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = "com.identity.platform.config.service.infrastructure.persistence")
public class DatabaseConfig {
}
