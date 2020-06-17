export default interface PageableDto<T> {
  data: T[];
  qtyPages?: number;
}
