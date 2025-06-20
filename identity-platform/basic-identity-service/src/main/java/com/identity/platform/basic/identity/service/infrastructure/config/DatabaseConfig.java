package com.identity.platform.basic.identity.service.infrastructure.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = "com.identity.platform.basic.identity.service.infrastructure.persistence")
public class DatabaseConfig {
}
