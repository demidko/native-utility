FROM gcc as builder
WORKDIR /project
COPY src ./src
COPY xmake.lua ./xmake.lua
RUN curl -fsSL https://xmake.io/shget.text | bash
RUN /root/.local/bin/xmake -qy --root
RUN /root/.local/bin/xmake run -qy --root test

FROM debian as backend
WORKDIR root
COPY --from=builder /project/app ./app
ENTRYPOINT ["./root/app"]