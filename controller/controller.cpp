/**
    @file
    @author Jan Michalczyk
    @copyright 2014-2017 INRIA. Licensed under the Apache License, Version 2.0.
    (see @ref LICENSE or http://www.apache.org/licenses/LICENSE-2.0)

    @brief
*/

#include <iostream>
#include <limits>
#include <iomanip>

#define HUMOTO_GLOBAL_LOGGER_ENABLED

// Enable YAML configuration files (must be first)
#include "humoto/config_yaml.h"
// common & abstract classes
#include "humoto/humoto.h"

#include "controller.h"

HUMOTO_INITIALIZE_GLOBAL_LOGGER(std::cout);

/**
 * @brief Simple control loop
 *
 * @return status
 */
int main(int argc, char **argv)
{
    try
    {
        HUMOTO_LOG_RAW("Controller template.");
    }
    catch (const std::exception &e)
    {
        HUMOTO_LOG_RAW(e.what());
        exit(-1);
    }
    return(0);
}
