package com.epilogue.domain.will;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UseMemorial {
    True("true"),
    False("false");

    UseMemorial(String s) {
    }
}
