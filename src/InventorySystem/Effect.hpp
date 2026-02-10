#pragma once

enum EffectType {
    HEAL,
    DAMAGE,
    STUN,
    SKILL_LVL,
    PROJECTILE,

    EFFECT_COUNT
};

enum EffectTrigger {
    ON_USE,
    ON_UPDATE,
    ON_EQUIP,
    ON_HIT,

    EFFECT_TRIGGER_COUNT
};

// Fat struct - members may be completely ignored in situations
// Keep packed
struct EffectData {
    float ammount;
    float ammount2;
    float ammount3;
    float durantion;
    float cooldown;
    // ...
};

struct Effect {
    EffectData data;
    EffectType type;
    EffectTrigger trigger;
};
