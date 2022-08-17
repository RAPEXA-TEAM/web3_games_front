const SHIFT = [0, 8, 16, 24];
const RC = [
  1,
  0,
  32898,
  0,
  32906,
  2147483648,
  2147516416,
  2147483648,
  32907,
  0,
  2147483649,
  0,
  2147516545,
  2147483648,
  32777,
  2147483648,
  138,
  0,
  136,
  0,
  2147516425,
  0,
  2147483658,
  0,
  2147516555,
  0,
  139,
  2147483648,
  32905,
  2147483648,
  32771,
  2147483648,
  32770,
  2147483648,
  128,
  2147483648,
  32778,
  0,
  2147483658,
  2147483648,
  2147516545,
  2147483648,
  32896,
  2147483648,
  2147483649,
  0,
  2147516424,
  2147483648
];

// private
void f(List<int> s) {
  var h,
      l,
      n,
      c0,
      c1,
      c2,
      c3,
      c4,
      c5,
      c6,
      c7,
      c8,
      c9,
      b0,
      b1,
      b2,
      b3,
      b4,
      b5,
      b6,
      b7,
      b8,
      b9,
      b10,
      b11,
      b12,
      b13,
      b14,
      b15,
      b16,
      b17,
      b18,
      b19,
      b20,
      b21,
      b22,
      b23,
      b24,
      b25,
      b26,
      b27,
      b28,
      b29,
      b30,
      b31,
      b32,
      b33,
      b34,
      b35,
      b36,
      b37,
      b38,
      b39,
      b40,
      b41,
      b42,
      b43,
      b44,
      b45,
      b46,
      b47,
      b48,
      b49;
  for (n = 0; n < 48; n += 2) {
    c0 = s[0] ^ s[10] ^ s[20] ^ s[30] ^ s[40] & 0xFFFFFFFF;
    c1 = s[1] ^ s[11] ^ s[21] ^ s[31] ^ s[41] & 0xFFFFFFFF;
    c2 = s[2] ^ s[12] ^ s[22] ^ s[32] ^ s[42] & 0xFFFFFFFF;
    c3 = s[3] ^ s[13] ^ s[23] ^ s[33] ^ s[43] & 0xFFFFFFFF;
    c4 = s[4] ^ s[14] ^ s[24] ^ s[34] ^ s[44] & 0xFFFFFFFF;
    c5 = s[5] ^ s[15] ^ s[25] ^ s[35] ^ s[45] & 0xFFFFFFFF;
    c6 = s[6] ^ s[16] ^ s[26] ^ s[36] ^ s[46] & 0xFFFFFFFF;
    c7 = s[7] ^ s[17] ^ s[27] ^ s[37] ^ s[47] & 0xFFFFFFFF;
    c8 = s[8] ^ s[18] ^ s[28] ^ s[38] ^ s[48] & 0xFFFFFFFF;
    c9 = s[9] ^ s[19] ^ s[29] ^ s[39] ^ s[49] & 0xFFFFFFFF;

    h = c8 ^ ((c2 << 1) | (c3 >> 31)) & 0xFFFFFFFF;
    l = c9 ^ ((c3 << 1) | (c2 >> 31)) & 0xFFFFFFFF;
    s[0] ^= h;
    s[1] ^= l;
    s[10] ^= h;
    s[11] ^= l;
    s[20] ^= h;
    s[21] ^= l;
    s[30] ^= h;
    s[31] ^= l;
    s[40] ^= h;
    s[41] ^= l;
    h = c0 ^ ((c4 << 1) | (c5 >> 31)) & 0xFFFFFFFF;
    l = c1 ^ ((c5 << 1) | (c4 >> 31)) & 0xFFFFFFFF;
    s[2] ^= h;
    s[3] ^= l;
    s[12] ^= h;
    s[13] ^= l;
    s[22] ^= h;
    s[23] ^= l;
    s[32] ^= h;
    s[33] ^= l;
    s[42] ^= h;
    s[43] ^= l;
    h = c2 ^ ((c6 << 1) | (c7 >> 31)) & 0xFFFFFFFF;
    l = c3 ^ ((c7 << 1) | (c6 >> 31)) & 0xFFFFFFFF;
    s[4] ^= h;
    s[5] ^= l;
    s[14] ^= h;
    s[15] ^= l;
    s[24] ^= h;
    s[25] ^= l;
    s[34] ^= h;
    s[35] ^= l;
    s[44] ^= h;
    s[45] ^= l;
    h = c4 ^ ((c8 << 1) | (c9 >> 31)) & 0xFFFFFFFF;
    l = c5 ^ ((c9 << 1) | (c8 >> 31)) & 0xFFFFFFFF;
    s[6] ^= h;
    s[7] ^= l;
    s[16] ^= h;
    s[17] ^= l;
    s[26] ^= h;
    s[27] ^= l;
    s[36] ^= h;
    s[37] ^= l;
    s[46] ^= h;
    s[47] ^= l;
    h = c6 ^ ((c0 << 1) | (c1 >> 31)) & 0xFFFFFFFF;
    l = c7 ^ ((c1 << 1) | (c0 >> 31)) & 0xFFFFFFFF;
    s[8] ^= h;
    s[9] ^= l;
    s[18] ^= h;
    s[19] ^= l;
    s[28] ^= h;
    s[29] ^= l;
    s[38] ^= h;
    s[39] ^= l;
    s[48] ^= h;
    s[49] ^= l;

    for (var i = 0; i < s.length; ++i) {
      s[i] = s[i] & 0xFFFFFFFF;
    }

    b0 = s[0];
    b1 = s[1];
    b32 = (s[11] << 4 & 0xFFFFFFFF) | (s[10] >> 28);
    b33 = (s[10] << 4 & 0xFFFFFFFF) | (s[11] >> 28);
    b14 = (s[20] << 3 & 0xFFFFFFFF) | (s[21] >> 29);
    b15 = (s[21] << 3 & 0xFFFFFFFF) | (s[20] >> 29);
    b46 = (s[31] << 9 & 0xFFFFFFFF) | (s[30] >> 23);
    b47 = (s[30] << 9 & 0xFFFFFFFF) | (s[31] >> 23);
    b28 = (s[40] << 18 & 0xFFFFFFFF) | (s[41] >> 14);
    b29 = (s[41] << 18 & 0xFFFFFFFF) | (s[40] >> 14);
    b20 = (s[2] << 1 & 0xFFFFFFFF) | (s[3] >> 31);
    b21 = (s[3] << 1 & 0xFFFFFFFF) | (s[2] >> 31);
    b2 = (s[13] << 12 & 0xFFFFFFFF) | (s[12] >> 20);
    b3 = (s[12] << 12 & 0xFFFFFFFF) | (s[13] >> 20);
    b34 = (s[22] << 10 & 0xFFFFFFFF) | (s[23] >> 22);
    b35 = (s[23] << 10 & 0xFFFFFFFF) | (s[22] >> 22);
    b16 = (s[33] << 13 & 0xFFFFFFFF) | (s[32] >> 19);
    b17 = (s[32] << 13 & 0xFFFFFFFF) | (s[33] >> 19);
    b48 = (s[42] << 2 & 0xFFFFFFFF) | (s[43] >> 30);
    b49 = (s[43] << 2 & 0xFFFFFFFF) | (s[42] >> 30);
    b40 = (s[5] << 30 & 0xFFFFFFFF) | (s[4] >> 2);
    b41 = (s[4] << 30 & 0xFFFFFFFF) | (s[5] >> 2);
    b22 = (s[14] << 6 & 0xFFFFFFFF) | (s[15] >> 26);
    b23 = (s[15] << 6 & 0xFFFFFFFF) | (s[14] >> 26);
    b4 = (s[25] << 11 & 0xFFFFFFFF) | (s[24] >> 21);
    b5 = (s[24] << 11 & 0xFFFFFFFF) | (s[25] >> 21);
    b36 = (s[34] << 15 & 0xFFFFFFFF) | (s[35] >> 17);
    b37 = (s[35] << 15 & 0xFFFFFFFF) | (s[34] >> 17);
    b18 = (s[45] << 29 & 0xFFFFFFFF) | (s[44] >> 3);
    b19 = (s[44] << 29 & 0xFFFFFFFF) | (s[45] >> 3);
    b10 = (s[6] << 28 & 0xFFFFFFFF) | (s[7] >> 4);
    b11 = (s[7] << 28 & 0xFFFFFFFF) | (s[6] >> 4);
    b42 = (s[17] << 23 & 0xFFFFFFFF) | (s[16] >> 9);
    b43 = (s[16] << 23 & 0xFFFFFFFF) | (s[17] >> 9);
    b24 = (s[26] << 25 & 0xFFFFFFFF) | (s[27] >> 7);
    b25 = (s[27] << 25 & 0xFFFFFFFF) | (s[26] >> 7);
    b6 = (s[36] << 21 & 0xFFFFFFFF) | (s[37] >> 11);
    b7 = (s[37] << 21 & 0xFFFFFFFF) | (s[36] >> 11);
    b38 = (s[47] << 24 & 0xFFFFFFFF) | (s[46] >> 8);
    b39 = (s[46] << 24 & 0xFFFFFFFF) | (s[47] >> 8);
    b30 = (s[8] << 27 & 0xFFFFFFFF) | (s[9] >> 5);
    b31 = (s[9] << 27 & 0xFFFFFFFF) | (s[8] >> 5);
    b12 = (s[18] << 20 & 0xFFFFFFFF) | (s[19] >> 12);
    b13 = (s[19] << 20 & 0xFFFFFFFF) | (s[18] >> 12);
    b44 = (s[29] << 7 & 0xFFFFFFFF) | (s[28] >> 25);
    b45 = (s[28] << 7 & 0xFFFFFFFF) | (s[29] >> 25);
    b26 = (s[38] << 8 & 0xFFFFFFFF) | (s[39] >> 24);
    b27 = (s[39] << 8 & 0xFFFFFFFF) | (s[38] >> 24);
    b8 = (s[48] << 14 & 0xFFFFFFFF) | (s[49] >> 18);
    b9 = (s[49] << 14 & 0xFFFFFFFF) | (s[48] >> 18);

    s[0] = b0 ^ (~b2 & b4);
    s[1] = b1 ^ (~b3 & b5);
    s[10] = b10 ^ (~b12 & b14);
    s[11] = b11 ^ (~b13 & b15);
    s[20] = b20 ^ (~b22 & b24);
    s[21] = b21 ^ (~b23 & b25);
    s[30] = b30 ^ (~b32 & b34);
    s[31] = b31 ^ (~b33 & b35);
    s[40] = b40 ^ (~b42 & b44);
    s[41] = b41 ^ (~b43 & b45);
    s[2] = b2 ^ (~b4 & b6);
    s[3] = b3 ^ (~b5 & b7);
    s[12] = b12 ^ (~b14 & b16);
    s[13] = b13 ^ (~b15 & b17);
    s[22] = b22 ^ (~b24 & b26);
    s[23] = b23 ^ (~b25 & b27);
    s[32] = b32 ^ (~b34 & b36);
    s[33] = b33 ^ (~b35 & b37);
    s[42] = b42 ^ (~b44 & b46);
    s[43] = b43 ^ (~b45 & b47);
    s[4] = b4 ^ (~b6 & b8);
    s[5] = b5 ^ (~b7 & b9);
    s[14] = b14 ^ (~b16 & b18);
    s[15] = b15 ^ (~b17 & b19);
    s[24] = b24 ^ (~b26 & b28);
    s[25] = b25 ^ (~b27 & b29);
    s[34] = b34 ^ (~b36 & b38);
    s[35] = b35 ^ (~b37 & b39);
    s[44] = b44 ^ (~b46 & b48);
    s[45] = b45 ^ (~b47 & b49);
    s[6] = b6 ^ (~b8 & b0);
    s[7] = b7 ^ (~b9 & b1);
    s[16] = b16 ^ (~b18 & b10);
    s[17] = b17 ^ (~b19 & b11);
    s[26] = b26 ^ (~b28 & b20);
    s[27] = b27 ^ (~b29 & b21);
    s[36] = b36 ^ (~b38 & b30);
    s[37] = b37 ^ (~b39 & b31);
    s[46] = b46 ^ (~b48 & b40);
    s[47] = b47 ^ (~b49 & b41);
    s[8] = b8 ^ (~b0 & b2);
    s[9] = b9 ^ (~b1 & b3);
    s[18] = b18 ^ (~b10 & b12);
    s[19] = b19 ^ (~b11 & b13);
    s[28] = b28 ^ (~b20 & b22);
    s[29] = b29 ^ (~b21 & b23);
    s[38] = b38 ^ (~b30 & b32);
    s[39] = b39 ^ (~b31 & b33);
    s[48] = b48 ^ (~b40 & b42);
    s[49] = b49 ^ (~b41 & b43);

    s[0] ^= RC[n];
    s[1] ^= RC[n + 1];
  }
}

// private
List<int> unshift(List<int> origin, List<int> new_head) {
  var new_array = new_head;
  new_array.addAll(origin);
  return new_array;
}


const SHAKE_PADDING = [31, 7936, 2031616, 520093696];
const CSHAKE_PADDING = [4, 1024, 262144, 67108864];
const KECCAK_PADDING = [1, 256, 65536, 16777216];
const SHA3_PADDING = [6, 1536, 393216, 100663296];

const NORMAL_BITS = [224, 256, 384, 512];
const SHAKE_BITS = [128, 256];

const FINALIZE_ERROR = 'finalize already called';

/// A SHA3 has params: int bits, List<int> padding, int outputBits
/// Avaliable `bits`:
///   - for keccak and sha3: use number in `NORMAL_BITS`: [224, 256, 384, 512];
///   - for shake cshake: use number in `SHAKE_BITS`: [128, 256];
/// Avaliable `padding`:
///   - `SHA3_PADDING`: for sha3;
///   - `KECCAK_PADDING`: for keccak;
///   - `SHAKE_PADDING`: for shake;
///   - `CSHAKE_PADDING`: for cshake;
/// Avaliable `outputBits`:
///   same to `bits`;
class SHA3 {
  List<int>? blocks;
  List<int>? s;
  List<int>? padding;
  var reset = true;
  var finalized = false;
  var block = 0;
  var start = 0;
  int? blockCount;
  int? byteCount;
  int? outputBlocks;
  int? outputBits;
  int? extraBytes;
  int lastByteIndex = 0;

  SHA3(int bits, List<int> padding, int outputBits) {
    this.padding = padding;
    this.outputBits = outputBits;
    blockCount = (1600 - (bits << 1)) >> 5;
    byteCount = blockCount! << 2;
    outputBlocks = outputBits >> 5;
    extraBytes = (outputBits & 31) >> 3;

    s = List<int>.filled(50, 0, growable: true);
    blocks = List<int>.filled(blockCount! + 1, 0, growable: true);
  }

  // update inputs the ascii/utf8 encoded int array and return the class itself for next step
  SHA3 update(List<int> message) {
    if (finalized) {
      throw Exception(FINALIZE_ERROR);
    }

    var blocks = this.blocks,
        byteCount = this.byteCount,
        length = message.length,
        blockCount = this.blockCount,
        index = 0,
        s = this.s,
        i;

    while (index < length) {
      if (reset) {
        reset = false;
        blocks![0] = block;
        for (i = 1; i < blockCount! + 1; ++i) {
          blocks[i] = 0;
        }
      }

      for (i = start; index < length && i < byteCount; ++index) {
        blocks![i >> 2] |= message[index] << SHIFT[i++ & 3];
      }

      lastByteIndex = i;
      if (i >= byteCount) {
        start = i - byteCount;
        block = blocks![blockCount!];
        for (i = 0; i < blockCount; ++i) {
          s![i] ^= blocks[i];
        }
        f(s!);
        reset = true;
      } else {
        start = i;
      }
    }

    return this;
  }

  // encode is not used yet, maybe will be deleted
  int encode(int x, bool right) {
    var o = x & 255, n = 1;
    var bytes = [o];
    x = x >> 8;
    o = x & 255;
    while (o > 0) {
      bytes = unshift(bytes, [o]);
      x = x >> 8;
      o = x & 255;
      ++n;
    }
    if (right) {
      bytes.add(n);
    } else {
      bytes = unshift(bytes, [n]);
    }
    update(bytes);
    return bytes.length;
  }

  // finalize is called by digest
  void finalize() {
    if (finalized) {
      return;
    }

    finalized = true;
    var blocks = this.blocks,
        i = lastByteIndex,
        blockCount = this.blockCount,
        s = this.s;

    blocks![i >> 2] |= padding![i & 3];
    if (lastByteIndex == byteCount) {
      blocks[0] = blocks[blockCount!];
      for (var i = 1; i < blockCount + 1; ++i) {
        blocks[i] = 0;
      }
    }

    blocks[blockCount! - 1] |= 0x80000000;
    for (var i = 0; i < blockCount; ++i) {
      s![i] ^= blocks[i];
    }
    f(s!);
  }

  // digest will sum and return a int list as hash
  List<int> digest() {
    finalize();

    var blockCount = this.blockCount,
        s = this.s,
        outputBlocks = this.outputBlocks,
        extraBytes = this.extraBytes,
        i = 0,
        j = 0;
    var array =
    List<int>.filled((outputBlocks! << 2), 0); // final hash Uint8Array
    var offset, block;
    while (j < outputBlocks) {
      for (i = 0; i < blockCount! && j < outputBlocks; ++i, ++j) {
        offset = j << 2;
        block = s![i];
        array[offset] = block & 0xFF;
        array[offset + 1] = (block >> 8) & 0xFF;
        array[offset + 2] = (block >> 16) & 0xFF;
        array[offset + 3] = (block >> 24) & 0xFF;
      }
      if (j % blockCount == 0) {
        f(s!);
      }
    }
    if (extraBytes! > 0) {
      offset = j << 2 & 0xFFFFFFFF;
      block = s![i];
      array[offset] = block & 0xFF;
      if (extraBytes > 1) {
        array[offset + 1] = (block >> 8) & 0xFF;
      }
      if (extraBytes > 2) {
        array[offset + 2] = (block >> 16) & 0xFF;
      }
    }
    return array;
  }
}

/// KMAC: dynamic bits, dynamic padding, dynamic outputBits
/// Avaliable `bits`: use number in `SHAKE_BITS`: [128, 256];
/// Avaliable `padding`: `CSHAKE_PADDING`;
/// Avaliable `outputBits`: same to `bits`;
class KMAC extends SHA3 {
  KMAC(bits, padding, outputBits) : super(bits, padding, outputBits);

  @override
  void finalize() {
    encode(outputBits!, true);
    return super.finalize();
  }
}




// _test(){
  /* SHA3(int bits, List<int> padding, int outputBits)
    Avaliable `bits`:
      - for keccak and sha3: use number in `NORMAL_BITS`: [224, 256, 384, 512];
      - for shake cshake: use number in `SHAKE_BITS`: [128, 256];
    Avaliable `padding`:
      - SHA3_PADDING: for sha3;
      - KECCAK_PADDING: for keccak;
      - SHAKE_PADDING: for shake;
      - CSHAKE_PADDING: for cshake;
    Avaliable `outputBits`:
      same to `bits`;
   */
//   var k = SHA3(256, KECCAK_PADDING, 256);
//   k.update(utf8.encode('Hello'));
//   var hash = k.digest();
//   print(HEX.encode(
//       hash)); // 06b3dfaec148fb1bb2b066f10ec285e7c9bf402ab32aa78a5d38e34566810cd2
//
// /* KMAC(dynamic bits, dynamic padding, dynamic outputBits)
//     Avaliable `bits`: use number in `SHAKE_BITS`: [128, 256];
//     Avaliable `padding`: CSHAKE_PADDING;
//     Avaliable `outputBits`: same to `bits`;
//    */
//   var kmac = KMAC(256, CSHAKE_PADDING, 256);
//   kmac.update(utf8.encode('Hello'));
//   var kmac_hash = kmac.digest();
//   print(HEX.encode(kmac_hash));
// }


