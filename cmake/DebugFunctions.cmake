#[[
@brief 打印输出LIST变量
@param _list_variable LIST变量
]]
function(print_list_variable _list_variable)
  message(STATUS)
  message(STATUS ${_list_variable})

  foreach(_variable ${${_list_variable}})
    message(STATUS "    ${_variable}")
  endforeach()
endfunction()

#[[
@brief 打印输出环境变量
@param _environment_variable 环境变量
]]
function(print_environment_variable _environment_variable)
  message(STATUS)
  message(STATUS ${_environment_variable})

  STRING(REGEX REPLACE ":" ";" _lines "$ENV{${_environment_variable}}")

  foreach(_variable ${_lines})
    message(STATUS "    ${_variable}")
  endforeach()
endfunction()

#[[
@brief 输出当前目录下的所有变量
]]
function(print_all_directory_variables)
  message(STATUS)
  get_property(_variables DIRECTORY PROPERTY VARIABLES)

  foreach(_variable ${_variables})
    message(STATUS "    ${_variable}=${${_variable}}")
  endforeach()
endfunction()

#[[
@brief 打印输出当前目录下与指定正则表达式匹配的变量
@param _regex 正则表达式
]]
function(print_directory_variables_with_regex _regex)
  message(STATUS)
  message(STATUS ${_regex})
  get_property(_variables DIRECTORY PROPERTY VARIABLES)

  foreach(_variable ${_variables})
    if(_variable MATCHES "${_regex}")
      message(STATUS "    ${_variable}=${${_variable}}")
    endif()
  endforeach()
endfunction()