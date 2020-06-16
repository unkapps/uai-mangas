export default class SortingDto {
  direction: 'ASC' | 'DESC';

  constructor(public name: string, direction: 'ASC' | 'DESC' = 'ASC') {
    this.direction = direction;
  }

  static fromString(string: string): SortingDto {
    if (string == null) {
      return null;
    }

    const regex = /^([\w\d\-]+)(, (ASC|DESC))?$/i;

    const match = regex.exec(string);

    if (match) {
      const name = match[1];
      let direction;

      if (match.length > 3) {
        direction = match[3].toUpperCase();
      }

      return new SortingDto(name, direction);
    }

    throw new Error(`Invalid string: ${string}`);
  }
}
