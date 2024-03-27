package com.epilogue.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.apache.http.HttpHeaders;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI openAPI() {
        String key = "Access Token (Bearer)";

        Info info = new Info()
                .title("Epilogue API 명세서")
                .version("v1")
                .description("Epilogue의 API 명세서입니다.");

        SecurityRequirement securityRequirement = new SecurityRequirement()
                .addList(key);

        SecurityScheme accessTokenSecurityScheme = new SecurityScheme()
                .type(SecurityScheme.Type.HTTP)
                .scheme("bearer")
                .in(SecurityScheme.In.HEADER);

        Components components = new Components()
                .addSecuritySchemes(key, accessTokenSecurityScheme);

        return new OpenAPI()
                .addSecurityItem(securityRequirement)
                .components(components)
                .info(info);
    }
}
