class StringHelper{

  static String patternString( String? fullname ){
    if( fullname != null){
      return fullname.split(' ').map(
        (name) {
          if( name == '' ) return '';
          return name[0] + name.substring(1).toLowerCase();
        }
      ).join(' ');
    }else{
      return '';
    }
  }


}