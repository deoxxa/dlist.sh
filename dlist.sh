dlist_init() {
  local dlist_name=${1}

  eval _DLIST_${dlist_name}_length=0
}

dlist_get() {
  local dlist_name=${1}
  local dlist_offset=${2}

  eval echo \$_DLIST_${dlist_name}_${dlist_offset}
}

dlist_set() {
  local dlist_name=${1}
  local dlist_offset=${2}
  local dlist_value=${3}

  eval _DLIST_${dlist_name}_${dlist_offset}=${dlist_value}
}

dlist_length() {
  local dlist_name=${1}

  eval echo \$_DLIST_${dlist_name}_length
}

dlist_push() {
  local dlist_name=${1}
  local dlist_value=${2}

  local n=$( dlist_length ${dlist_name} )

  : $(( _DLIST_${dlist_name}_length += 1 ))

  dlist_set ${dlist_name} ${n} ${dlist_value}
}

dlist_pop() {
  local dlist_name=${1}

  local n=$( dlist_length ${dlist_name} )

  if [ ${n} -lt 1 ]; then
    return;
  fi;

  eval unset _DLIST_${dlist_name}_$(( n - 1 ))

  : $(( _DLIST_${dlist_name}_length -= 1 ))
}

dlist_unshift() {
  local dlist_name=${1}
  local dlist_value = ${2}

  local n=$( dlist_length ${dlist_name} )

  for i in $( seq 0 $(( n - 1 )) ); do
    dlist_set ${dlist_name} $(( i + 1 )) $( dlist_get ${dlist_name} ${i} )
  done;

  dlist_set ${dlist_name} 0 ${dlist_value}

  : $(( _DLIST_${dlist_name}_length += 1 ))
}

dlist_shift() {
  local dlist_name=${1}

  local n=$( dlist_length ${dlist_name} )

  for i in $( seq 0 $(( n - 2 )) ); do
    dlist_set ${dlist_name} ${i} $( dlist_get ${dlist_name} $(( i + 1 )) )
  done;

  eval unset _DLIST_${dlist_name}_$(( n - 1 ))

  : $(( _DLIST_${dlist_name}_length -= 1 ))
}
