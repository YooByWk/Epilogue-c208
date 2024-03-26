package com.epilogue.domain.user;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Status {
    Live("live"),
    DeadAndSend("deadAndSend"),
    DeadAndNotSend("deadAndNotSend");

    Status(String s) {
    }
}
