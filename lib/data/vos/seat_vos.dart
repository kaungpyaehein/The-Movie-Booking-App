class SeatVo {
  String text = "";
  String type = "";
  SeatVo(this.text, this.type);
}

List<SeatVo> seatList = [
  SeatVo("A", "text"),
  SeatVo("", "taken"),
  SeatVo("", "space"),
  SeatVo("", "available"),
];

List<SeatVo> seatList1 = [
  SeatVo("A", "text"),
  SeatVo("", "taken"),
  SeatVo("", "taken"),
  SeatVo("", "taken"),
  SeatVo("", "taken"),
  SeatVo("", "space"),
  SeatVo("", "space"),
  SeatVo("", "taken"),
  SeatVo("", "taken"),
  SeatVo("", "taken"),
  SeatVo("", "taken"),
  SeatVo("A", "text"),
  SeatVo("B", "text"),
  SeatVo("", "taken"),
  SeatVo("", "taken"),
  SeatVo("", "available"),
  SeatVo("", "available"),
  SeatVo("", "space"),
  SeatVo("", "space"),
  SeatVo("", "available"),
  SeatVo("", "taken"),
  SeatVo("", "taken"),
  SeatVo("", "taken"),
  SeatVo("B", "text"),
];
