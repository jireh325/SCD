package com.identity.platform.biometric.identity.service.infrastructure.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = "com.identity.platform.biometric.identity.service.infrastructure.persistence")
public class DatabaseConfig {
}
