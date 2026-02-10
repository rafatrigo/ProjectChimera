#pragma once

#include <string>
#include <vector>

#include "Effect.hpp"

enum ItemType {
    WEAPON,
    EQUIPMENT,
    GARMENT,
    CONSUMABLE,

    TYPE_COUNT
};

enum ItemRarity {
    COMMOM,
    UNCOMMON,
    RARE,
    VERY_RARE,
    LEGENDARY,

    RARITY_COUNT
};

struct Item {
    std::vector<Effect> effects;
    std::string itemName; // Note: Consider switching this to a fixed size char[]
    ItemType type;
    ItemRarity rarity;
};

