import numpy as np, wave, subprocess, sys
SR=32000; L=24; N=SR*L
rng=np.random.default_rng(7)
t=np.arange(N)/SR

def shaped(lo, hi, tilt=0.0):
    # circular noise (loops seamlessly): band between lo and hi, spectrum ~ f^-tilt
    X=np.fft.rfft(rng.standard_normal(N))
    f=np.fft.rfftfreq(N,1/SR)
    g=np.zeros_like(f)
    band=(f>=lo)&(f<=hi)
    g[band]=1/np.maximum(f[band],1)**(tilt/2)
    # soft edges
    g*=1/(1+np.exp(-(f-lo)/(lo*0.2+1)))*1/(1+np.exp((f-hi)/(hi*0.1+1)))
    y=np.fft.irfft(X*g,N); return y/np.max(np.abs(y))

def place(buf, ev, at):
    idx=(np.arange(len(ev))+at)%N; np.add.at(buf, idx, ev)

def norm(y,peak=0.7): return y/np.max(np.abs(y))*peak

def waves():
    surf=shaped(60,6000,1.2)
    hiss=shaped(1500,9000,0.5)
    sw=np.zeros(N)
    for k,ph in [(3,0.0),(2,1.3)]:
        sw+= (0.5-0.5*np.cos(2*np.pi*k*t/L+ph))**3
    sw/=sw.max()
    return norm(surf*(0.15+0.85*sw)+0.35*hiss*sw**2)

def rain():
    y=0.5*shaped(400,12000,0.6)
    for _ in range(1800):
        n=int(SR*rng.uniform(0.004,0.02)); f=rng.uniform(1500,6000)
        e=np.sin(2*np.pi*f*np.arange(n)/SR)*np.exp(-np.arange(n)/(n/5))*rng.uniform(0.05,0.3)
        place(y,e,int(rng.integers(N)))
    return norm(y)

def birds():
    y=0.08*shaped(150,2000,1.0)*(0.7+0.3*np.sin(2*np.pi*t/L))
    for _ in range(46):
        at=int(rng.integers(N)); notes=int(rng.integers(2,6)); base=rng.uniform(2200,4200); pos=at
        kind=rng.integers(3)
        for i in range(notes):
            d=rng.uniform(0.05,0.16); n=int(SR*d); tt=np.arange(n)/SR
            if kind==0: f=base+1500*np.sin(np.pi*tt/d)          # arc
            elif kind==1: f=base*(1+0.6*tt/d)                    # rising
            else: f=base*(1.4-0.5*tt/d)                          # falling
            f=f+120*np.sin(2*np.pi*rng.uniform(20,45)*tt)       # warble
            ph=2*np.pi*np.cumsum(f)/SR
            env=np.sin(np.pi*tt/d)**2*rng.uniform(0.2,0.5)
            place(y,env*(np.sin(ph)+0.15*np.sin(2*ph)),pos)
            pos+=n+int(SR*rng.uniform(0.03,0.12))
    return norm(y)

def chimes():
    y=0.03*shaped(100,3000,1.5)
    scale=[523.25,587.33,659.25,783.99,880.0,1046.5,1174.66]
    for _ in range(40):
        f=scale[rng.integers(len(scale))]*rng.choice([1,1,2]); n=int(SR*5); tt=np.arange(n)/SR
        tone=sum(a*np.sin(2*np.pi*f*m*tt)*np.exp(-tt*(1.0+m*0.9)) for m,a in [(1,1),(2.76,0.4),(5.4,0.2),(8.93,0.1)])
        tone*=np.minimum(1,tt/0.003)*rng.uniform(0.15,0.4)
        place(y,tone,int(rng.integers(N)))
    return norm(y)

def night():
    y=0.12*shaped(80,1200,1.3)
    for c,(f,rate) in enumerate([(4300,16.0),(4700,13.0),(3900,18.5)]):
        chirp_on=(np.sin(2*np.pi*rate*t)>0.3).astype(float)
        groups=(np.sin(2*np.pi*(c+2)*t/L*3+c)>-0.2).astype(float)
        env=np.convolve(chirp_on*groups,np.ones(64)/64,mode='same')
        y+=0.25*env*np.sin(2*np.pi*f*t)*(0.6+0.4*np.sin(2*np.pi*t*(c+1)/L))
    for _ in range(10):  # a far owl-ish hoot
        n=int(SR*0.45); tt=np.arange(n)/SR
        e=np.sin(2*np.pi*(380-40*tt)*tt)*np.sin(np.pi*tt/0.45)**2*0.12
        place(y,e,int(rng.integers(N)))
    return norm(y)

for name,fn in [('gentle_waves',waves),('gentle_rain',rain),('gentle_birds',birds),('gentle_chimes',chimes),('gentle_night',night)]:
    y=fn()
    # fade-matched loop already circular; write
    pcm=(y*32767).astype(np.int16)
    with wave.open(name+'.wav','wb') as w:
        w.setnchannels(1); w.setsampwidth(2); w.setframerate(SR); w.writeframes(pcm.tobytes())
    subprocess.run(['ffmpeg','-y','-loglevel','error','-i',name+'.wav','-c:a','libvorbis','-q:a','3',name+'.ogg'],check=True)
    print(name)
