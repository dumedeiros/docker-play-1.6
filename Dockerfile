FROM openjdk:11

ENV PLAY_VERSION "1.5.3"
ENV PLAY_HOME /opt/play

# Play Framework installation
RUN cd /opt && \
	# Download play framework
	wget "https://www.dropbox.com/s/e73m06nhdfdhu9p/play.zip?dl=1" -O play.zip && \
	# Extract and clean archive
	unzip -q play.zip && rm play.zip && \
	# Set execution
	chmod +x /opt/play/play
# Create application folder

RUN mkdir -p /app

WORKDIR /app

EXPOSE 9000

HEALTHCHECK --interval=30s --timeout=3s \
	CMD curl --fail http://localhost:9000/ || exit 1

CMD ${PLAY_HOME}/play deps; ${PLAY_HOME}/play run /app ${ARGS}
