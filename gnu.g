LoadPackage("grpconst");
LoadPackage("sglppow");
LoadPackage("cubefree");



IsSquareFree:= n -> ForAll( Collected( Factors(n) ), x -> x[2] = 1 );

IsCubeFree:= n -> ForAll( Collected( Factors(n) ), x -> x[2] <= 2 );

GnuWithExplanation:=function(n)
local res;
if not IsPosInt(n) then
  Error("The argument of Gnu(n) must be a positive integer");
fi;

if IsCubeFree( n ) then
  res := NumberCFGroups( n );
  return [ res, Concatenation( "using NumberCFGroups from CubeFree ",
                               InstalledPackageVersion("cubefree")) ];
else
  res := CALL_WITH_CATCH( NrSmallGroups, [ n ] );
  if res[1] then
    if n = 3^8 or IsPrimePowerInt(n) and Length(Factors(n))=7 then
      return [ res[2], Concatenation( "using NrSmallGroups from SglPPow ",
                                      InstalledPackageVersion("sglppow")) ];
    else
      return [ res[2], "using NrSmallGroups and the GAP Small Groups Library" ];
    fi;
  else
    return [ false, Concatenation( List( res[2], String ) ) ];
  fi;
fi;

end;

Gnu:=function(n)
return GnuWithExplanation(n)[1];
end;
