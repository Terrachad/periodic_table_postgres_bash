#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

  if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
  else
    #check if input is a number
    if  [[ ! $1 =~ ^[0-9]+$ ]]
    then
      ELEMENT_INFO=$($PSQL "SELECT atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM ELEMENTS JOIN properties USING(atomic_number) join types USING (type_id) where symbol='$1' or name='$1'");
    else
      ELEMENT_INFO=$($PSQL "SELECT atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM ELEMENTS JOIN properties USING(atomic_number) join types USING (type_id) WHERE atomic_number=$1");
    fi

    if [[ -z $ELEMENT_INFO ]]
    then
    echo "I could not find that element in the database."
    
    else
        echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_C BAR BOILING_POINT_C BAR TYPE 
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_C celsius and a boiling point of $BOILING_POINT_C celsius."
        done
        
    fi
    

  fi

  #"SELECT * FROM ELEMENTS FULL JOIN properties ON elements.atomic_number = properties.atomic_number;"

  #"The element with atomic number <ATOMIC_NUMBER> is <ELEMENT_NAME> (<SYMBOL>). It's a nonmetal, with a mass of <ATOMIC_MASS> amu. Hydrogen has a melting point of <MELTING_POINT> celsius and a boiling point of <BOILING_POINT> celsius."
