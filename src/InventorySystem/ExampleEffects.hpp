#pragma once

#include "Effect.hpp"

constexpr Effect BurningEffect = {
    .data = {
        .ammount = 10,
        .durantion = 5
    },
    .type = DAMAGE,
    .trigger = ON_UPDATE
};

constexpr Effect FireballSpell = {
    .data = {
        .ammount = 200
    },
    .type = DAMAGE,
    .trigger = ON_USE
};
