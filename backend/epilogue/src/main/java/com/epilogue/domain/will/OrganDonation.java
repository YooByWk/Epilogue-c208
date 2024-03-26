package com.epilogue.domain.will;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OrganDonation {
    True("true"),
    False("false");

    OrganDonation(String s) {
    }
}