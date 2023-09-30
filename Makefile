#COMPILER=gcc
COMPILER=clang
CC=$(COMPILER)
OUT=libnuklear.a

src=$(wildcard src/*.c)
obj=$(src:.c=.o)
dep=$(obj:.o=.d)

INCLUDES=-Isrc/

FLAGS=-MMD $(WARNFLAGS) $(INCLUDES) -g -fPIC \
-DNK_INCLUDE_FIXED_TYPES \
-DNK_INCLUDE_STANDARD_IO \
-DNK_INCLUDE_STANDARD_VARARGS \
-DNK_INCLUDE_DEFAULT_ALLOCATOR \
-DNK_INCLUDE_VERTEX_BUFFER_OUTPUT \
-DNK_INCLUDE_FONT_BAKING \
-DNK_INCLUDE_DEFAULT_FONT \
-DNK_GLFW_GL3_IMPLEMENTATION \
-DNK_KEYSTATE_BASED_INPUT \
#-DNK_BUTTON_TRIGGER_ON_RELEASE \
-DNK_IMPLEMENTATION

CFLAGS=$(FLAGS) \
-DNK_MEMCPY=nk_memcopy \
-DNK_MEMSET=nk_memset\
-DNK_DTOA=nk_dtoa\
-DNK_COS=nk_cos\
-DNK_SIN=nk_sin\
-DNK_INV_SQRT=nk_inv_sqrt
#src/nuklear_util.c:17:#define NK_MEMCPY nk_memcopy
#src/nuklear_util.c:76:#define NK_MEMSET nk_memset
#src/nuklear_util.c:503:#define NK_DTOA nk_dtoa
#src/nuklear_math.c:68:#define NK_COS nk_cos
#src/nuklear_math.c:52:#define NK_SIN nk_sin
#src/nuklear_math.c:37:#define NK_INV_SQRT nk_inv_sqrt

CPPCHECK_OUT_DIR = cppcheck_html
CPPCHECK_OUT = report.xml

$(OUT): $(obj)
	$(AR) rcs $@ $^

-include $(dep)

#sca: $(CPPCHECK_OUT_DIR)
#scaclang: $(CLANG_OUT_DIR)

#$(CPPCHECK_OUT_DIR): $(CPPCHECK_OUT)
#	cppcheck-htmlreport --file=$< --report-dir=$@ --source-dir=. --language=c
#$(CPPCHECK_OUT):
#	cppcheck --xml --xml-version=2 --inconclusive --enable=all --language=c -v $(src) 2> $@

#$(CPPCHECK_OUT_DIR): $(CPPCHECK_OUT)
#	cppcheck-htmlreport --file=$< --report-dir=$@ --source-dir=.
#
#$(CPPCHECK_OUT):
#	cppcheck --xml --xml-version=2 --inconclusive --enable=all -v $(src) 2> $@


.PHONY: clean
clean:
	rm -rf cppcheck_html
	rm -f report.xml
	rm -f $(dep)
	rm -f $(obj) $(OUT)  # CPPCHECK_OUT CPPCHECK_OUT_DIR


