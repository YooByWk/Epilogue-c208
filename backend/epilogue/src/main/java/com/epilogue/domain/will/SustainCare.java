package com.epilogue.domain.will;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SustainCare {
    True("true"),
    False("false");

    SustainCare(String s) {
    }
}