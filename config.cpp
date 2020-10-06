class CfgPatches {
    class timemarkers {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.68;
        requiredAddons[] = {
            "A3_Data_F_Mod_Loadorder",
            "A3_Data_F_Oldman_Loadorder"
        };
        version = 1.1.3;
        author[] = {"S3Savage"};
        authorUrl = "";
    };
};

class CfgFunctions {
    class S3S {
        class timemarkers {
            class init {
                file = "\timemarkers\init.sqf";
                postInit = 1;
            };
        };
    };
};
