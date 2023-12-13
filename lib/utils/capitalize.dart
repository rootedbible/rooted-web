String capitalizeFirstLetter(String text) => text.isEmpty
    ? ''
    : '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
